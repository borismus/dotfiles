import * as PropTypes from 'prop-types';
import * as React from 'react';
import RaisedButton from 'material-ui/RaisedButton';
import IconCheck from 'material-ui/svg-icons/navigation/check';
import update from 'immutability-helper';

import { ref, User } from '../constants';
import { UserInfo } from './UserInfo';

/**
 * Shows people in a lobby.
 */

interface IProps {
  partyId: string;
  user: any;
}

interface IState {
  // Who is present in the lobby.
  users: User[]
}

export class Party extends React.Component<IProps, {}> {
  state = {
    users: {},
  }

  constructor(props: IProps) {
    super(props);
  }

  componentDidMount() {
    console.log(this.props.user, this.props.partyId);
  }

  componentWillUnmount() {
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
    const users = otherUsers.map((user: User, key) =>
      <UserInfo user={user} key={key} />);

    return <div>
      <h1>Party {this.props.partyId}</h1>
      {users}
      <RaisedButton label="I'm Ready!" icon={<IconCheck />}
        onClick={e => this.handleReady()} />
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
