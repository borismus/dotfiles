import * as firebase from 'firebase';
import * as React from 'react';
import { Redirect } from 'react-router-dom'
import {User} from '../constants';

import RaisedButton from 'material-ui/RaisedButton';

interface IProps {
}

interface IState {
  user: User
}


export class SignInStatus extends React.Component<IProps, IState> {
  constructor(props: IProps) {
    super(props);
    this.state = {
      user: null,
    };
  }

  componentDidMount() {
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        this.setState({user: user});
      } else {
        this.setState({user: null});
      }
    });
  }

  render() {
    let label;
    if (this.state.user) {
      label = `Sign out (${this.state.user.displayName})`;
    } else {
      label = 'Sign in';
    }
    return <RaisedButton label={label} onClick={e => this.handleClick()} />;
  }

  handleClick() {
    if (this.state.user) {
      // If we're signed in, sign out.
      firebase.auth().signOut();
    } else {
      return <Redirect to='/' />
    }
  }
}

