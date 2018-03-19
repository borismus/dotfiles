import * as React from 'react';
import { User } from '../constants';
import { Lobby } from './Lobby';
import { Party } from './Party';

interface IProps {
  user: User
}

export class Home extends React.Component<IProps, {}> {
  render() {
    const user = this.props.user;
    // If the user has a party, show the party view. Otherwise show the lobby.
    let view;
    if (user.party) {
      view = <Party user={user} partyId={user.party} />
    } else {
      view = <Lobby user={user} lobbyId='default' />
    }
    return <div>{view}</div>
  }
}
