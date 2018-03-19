import * as React from 'react';
import * as PropTypes from 'prop-types';

export interface UserProviderContext {
  user: any;
}

export class UserProvider extends React.Component<void, void> {
  static childContextTypes = {
    user: PropTypes.object
  }

  getChildContext(): UserProviderContext {
    return {
      user: null
    }
  }
}
