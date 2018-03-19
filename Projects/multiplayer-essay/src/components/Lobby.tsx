import * as PropTypes from 'prop-types';
import * as React from 'react';
import RaisedButton from 'material-ui/RaisedButton';
import IconCheck from 'material-ui/svg-icons/navigation/check';
import update from 'immutability-helper';

import { ref, User } from '../constants';
import { FindPartyDialog } from './FindPartyDialog';
import { UserInfo } from './UserInfo';

/**
 * Shows people in a lobby.
 */

interface IProps {
  lobbyId: string;
  user: User;
}

interface IState {
  // Who is present in the lobby.
  users: User[]
}

export class Lobby extends React.Component<IProps, {}> {
  static contextTypes = {
    user: PropTypes.object
  }

  state = {
    users: {},
  }

  constructor(props: IProps) {
    super(props);
  }

  componentDidMount() {
    console.log(this.props.user, this.props.lobbyId);
    // Once mounted, indicate presence in the lobby.
    const lobbyRef = ref.child(`lobbies/${this.props.lobbyId}`);
    const userRef = lobbyRef.child(`users/${this.props.user.uid}`);
    userRef.set(true);
    // Once unmounted, remove presence.
    userRef.onDisconnect().remove();

    // Whenever users change in Firebase, update state.
    const usersRef = ref.child(`lobbies/${this.props.lobbyId}/users`);
    const snapshot = usersRef.on('value', snap => this.handleLobbyUsersChanged(snap));
  }

  componentWillUnmount() {
    // Once unmounted, leave the lobby.
    const lobbyRef = ref.child(`lobbies/${this.props.lobbyId}`);
    const userRef = lobbyRef.child(`users/${this.props.user.uid}`);
    userRef.remove();
  }

  private async handleLobbyUsersChanged(snapshot) {
    const userIds = Object.keys(snapshot.val());

    // For each user, get full info.
    for (let uid of userIds) {
      const userRef = ref.child(`users/${uid}`);
      userRef.on('value', snap => this.handleUserChange(snap));
    }
  }

  private handleUserChange(snapshot) {
    // Find the user with this uid, and update it.
    const user = snapshot.val();
    console.log(`Updating users with ${user.uid}.`);
    const newUsers = update(this.state.users, {[user.uid]: {$set: user}});
    this.setState({users: newUsers});
  }

  render() {
    // Show everyone except yourself.
    const usersArray = Object.values(this.state.users);
    const otherUsers = usersArray.filter((user: User) =>
      user.uid != this.props.user.uid);
    const lobbyUsers = otherUsers.map((user: User, key) =>
      <UserInfo user={user} key={key} />);

    return <div>
      <h1>Lobby {this.props.lobbyId}</h1>
      <RaisedButton label="I'm Ready!" icon={<IconCheck />}
        onClick={e => this.handleReady()} />

      {lobbyUsers}

      <FindPartyDialog user={this.props.user} />
    </div>
  }

  private handleReady() {
    // Update Firebase user with the status change.
    ref.child(`users/${this.props.user.uid}`).update({
      readyParty: true,
      readyPartyTimestamp: (new Date().valueOf()),
    });
  }
}
