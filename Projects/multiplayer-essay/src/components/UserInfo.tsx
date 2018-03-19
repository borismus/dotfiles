import * as React from 'react';
import {Card, CardActions, CardHeader, CardMedia, CardTitle, CardText} from 'material-ui/Card';
import IconButton from 'material-ui/IconButton';
import IconCheckCircle from 'material-ui/svg-icons/action/check-circle';
import { User } from '../constants';

interface IProps {
  user: User
}

const styles = {
  iconCheck: {
    transform: 'scale(1.5)',
    float: 'right',
  },
};

export class UserInfo extends React.Component<IProps, {}> {
  render() {
    const user = this.props.user;
    const ready = user.readyParty ? <IconCheckCircle style={styles.iconCheck}/> : '';
    const subtitle = user.readyParty ? 'Ready!' : 'Waiting...';
    return <Card>
      <CardHeader
        avatar={user.photoURL}
        title={user.displayName}
        subtitle={subtitle}>
        {ready}
      </CardHeader>
    </Card>
  }
}
