var ConversationList = React.createClass({
  render: function() {
    return(
      <div>
        {this.props.conversations.map(function(conversation, index){
          return <ConversationListItem conversation={conversation} key={index} />;
        })}
      </div>
    )
  }
})