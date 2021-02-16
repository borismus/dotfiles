#!/usr/bin/env python3
import datetime
import dateutil.parser
import json
import os
import requests
import sys
import time
import optparse

parser = optparse.OptionParser()
parser.add_option('--days_ago', type='int')
parser.add_option('--verbose', action='store_true', dest='verbose')

ACCESS_TOKEN = None
ARTICLES_DIR = 'Articles'
BOOKS_DIR = 'Books'
UNKNOWN_DIR = 'Unknown'

def get_books(last_updated=None):
  querystring = {'page_size': 1000}
  if last_updated:
    querystring['last_highlight_at__gt'] = last_updated.strftime('%Y-%m-%dT%H:%M:%SZ')

  response = requests.get(
      url='https://readwise.io/api/v2/books/',
      headers={'Authorization': 'Token ' + access_token},
      params=querystring
  )

  book_data = response.json()['results']
  return book_data

def get_highlights_for_book(book_id):
  querystring = {
      'pagesize': 1000,
      'book_id': book_id,
  }

  response = requests.get(
      url='https://readwise.io/api/v2/highlights/',
      headers={'Authorization': 'Token ' + access_token},
      params=querystring
  )

  json = response.json()
  if not 'results' in json:
    return None
  highlights_data = json['results']
  return highlights_data

def get_filename(book):
  date_str = book['last_highlight_at']
  date = dateutil.parser.isoparse(date_str)
  date_iso = date.strftime('%Y-%m-%d')
  title = book['title']
  category = book['category']
  print(title, date_iso)
  if category == 'books':
    prefix = BOOKS_DIR
  elif category == 'articles':
    prefix = ARTICLES_DIR
  else:
    prefix = UNKNOWN_DIR
  return f'{prefix}/{title}.md'


def get_unixtime(book):
  date_str = book['last_highlight_at']
  date = dateutil.parser.isoparse(date_str)
  unixtime = time.mktime(date.timetuple())
  return unixtime

def format_book(book, highlights):
  title = book['title']
  url = book['highlights_url']
  out = f'''# {title}

<{url}>

'''
  for highlight in highlights:
    text = highlight['text']
    note = highlight['note']
    url = highlight['url']
    out += f'{text}'
    if url:
      out += f' [View highlight]({url})'
    out += '\n'
    if note:
      out += f'**Note**: {note}'
    out += '\n\n'

  return out


def mkdirs():
  # Make the subdirectories.
  if not os.path.exists(root):
    os.mkdir(root)
  for subdir in [ARTICLES_DIR, BOOKS_DIR, UNKNOWN_DIR]:
    dirpath = os.path.join(root, subdir)
    if not os.path.exists(dirpath):
      os.mkdir(dirpath)


if __name__ == '__main__':
  options, args = parser.parse_args()
  if len(args) != 1:
    print(f'Usage: {sys.argv[0]} output_path')
    sys.exit(1)

  if not 'READWISE_ACCESS_TOKEN' in os.environ:
    print(f'READWISE_ACCESS_TOKEN env var not set')
    sys.exit(1)

  access_token = os.environ['READWISE_ACCESS_TOKEN']

  root = os.path.expanduser(args[0])
  date_delta = None
  if options.days_ago:
    date_delta = datetime.datetime.now() - \
        datetime.timedelta(days=options.days_ago)
    print(f'Getting books from the last {options.days_ago} days')
  else:
    print(f'Getting all books')

  mkdirs()
  books = get_books(date_delta)
  for book in books:
    if options.verbose:
      title = book['title']
      print(f'Processing book {title}')
    filename = get_filename(book)
    path = os.path.join(root, filename)
    highlights = get_highlights_for_book(book['id'])
    if not highlights:
      if options.verbose:
        print(f'No highlights for {title}')
      continue
    out = format_book(book, highlights)

    f = open(path, 'w')
    f.write(out)
    f.close()
    mtime = get_unixtime(book)
    os.utime(path, (mtime, mtime))
