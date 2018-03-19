import * as React from 'react';
import { Route, HashRouter, Link, Redirect, Switch } from 'react-router-dom'

import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';


import { firebaseAuth, ref, User } from '../constants';
import { Home } from './Home';
import { SignInStatus } from './SignInStatus';
import { SignIn } from './SignIn';

interface IState {
  loading: boolean;
  user: User;
}

interface IProps {
}

function PrivateRoute ({component: Component, user, ...rest}) {
  return (
    <Route
      {...rest}
      render={(props) => !!user
        ? <Component {...props} {...rest} user={user} />
        : <Redirect to={{pathname: '/signin', state: {from: props.location}}} />}
    />
  )
}

function PublicRoute ({component: Component, user, ...rest}) {
  return (
    <Route
      {...rest}
      render={(props) => !user
        ? <Component {...props} />
        : <Redirect to='/' />}
    />
  )
}

export class App extends React.Component<IProps, IState> {
  removeListener: () => void;
  state = {
    loading: true,
    user: null,
  }

  componentDidMount() {
    this.removeListener = firebaseAuth().onAuthStateChanged((user) => {
      if (user) {
        // Don't store the Firebase User, instead store user info created from
        // the Firebase db at /users/{user.uid}.
        ref.child(`users/${user.uid}`).on('value', snap => {
          this.setState({
            user: snap.val(),
            loading: false,
          });
        });
      } else {
        this.setState({
          user: null,
          loading: false
        })
      }
    })
  }

  componentWillUnmount() {
    this.removeListener()
  }

  componentWillUpdate(nextProps: IProps, nextState) {
    const user = nextState.user;
    if (user) {
      // If this is a brand new user, save this user's info to Firebase.
      const userRef = ref.child(`users/${user.uid}`);
      userRef.update({
        displayName: user.displayName,
        photoURL: user.photoURL,
        uid: user.uid,
        metadata: user.metadata,
      });
    }
  }

  render() {
    if (this.state.loading === true) {
      return <h1>Loading</h1>
    }

    return <HashRouter>
      <MuiThemeProvider>
        <div>
          <SignInStatus />
          <Switch>
            <PrivateRoute user={this.state.user} lobbyId='default' path='/' exact component={Home} />
            <PublicRoute user={this.state.user} path='/signin' component={SignIn} />
          </Switch>
        </div>
      </MuiThemeProvider>
    </HashRouter>
  }
}

