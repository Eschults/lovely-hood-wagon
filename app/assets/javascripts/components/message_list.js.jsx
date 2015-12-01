var MessageList = React.createClass({
  render: function() {
    return (
      <div>
        <div className="stick-down-target padding-5">
          <p className="small gray-lighter text-center">
            {this.props.started_at}
          </p>
        </div>
        {this.props.messages.map(function(message, index){
          return <MessageListItem message={message} key={index} />;
        })}
      </div>
    );
  }
});