import React from 'react';

export default React.createClass({
  render() {
    return (
      <li>
        <a href={this.props.href}>
          <img src={this.props.thumb} width={this.props.width}
            alt={this.props.alt} />
        </a>
      </li>
    );
  }
});
