import * as React from 'react';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import {ref, User} from '../constants';

interface IProps {
  user: User;
}

interface IState {
  open: boolean;
}

const styles = {
  timeWaited: {
    fontSize: 20,
  },
};

export class FindPartyDialog extends React.Component<IProps, IState> {

  constructor(props: IProps) {
    super(props);
    this.state = {
      open: !!this.props.user.readyParty,
    }
  }

  componentWillReceiveProps(nextProps: IProps) {
    // Show only when the user indicates that they are ready.
    console.log('FindPartyDialog componentWillReceiveProps', nextProps);
    this.setState({
      open: !!nextProps.user.readyParty
    });
  }

  handleOpen = () => {
    this.setState({open: true});
  };

  handleClose = () => {
    this.setState({open: false});
  };

  render() {
    const user = this.props.user;
    let title;
    let actionTitle;
    if (!user.party) {
      // We're looking for a party.
      title = 'Finding party';
      actionTitle = 'Send Link';
    } else if (user.confirmPartyAllSet) {
      // Everyone has confirmed the party, and we're set to go!
      title = 'About to begin...';
      actionTitle = '...';
    } else if (user.confirmParty) {
      // We've confirmed the party, and now we're just waiting for everyone else
      // to confirm.
      title = 'Party found!';
      actionTitle = 'Confirm';
    }
    const timeWaited = '0:13';
    const waitEstimate = '1:10';

    const actions = [
      <FlatButton
        label="Cancel"
        primary={true}
        onClick={this.handleClose}
      />,
      <FlatButton
        label={actionTitle}
        primary={true}
        keyboardFocused={true}
        onClick={this.handleClose}
      />,
    ];
    return <Dialog
      title={title}
      actions={actions}
      modal={false}
      open={this.state.open}
      onRequestClose={this.handleClose}>
      <div style={styles.timeWaited}>{timeWaited}</div>
      Estimated: <span>{waitEstimate}</span>
    </Dialog>
  }
}
