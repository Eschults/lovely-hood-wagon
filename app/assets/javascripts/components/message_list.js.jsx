var MessageList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.messages.map(function(message, index){
          return <MessageListItem message={message} key={index} />;
        })}
      </div>
    );
  }
});