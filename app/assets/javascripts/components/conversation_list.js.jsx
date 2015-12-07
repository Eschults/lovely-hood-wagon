var ConversationList = React.createClass({
  render: function() {
    var that = this
    return(
      <div>
        {this.props.conversations.map(function(conversation, index){
          return <ConversationListItem conversation={conversation} key={index} onConversationSelection={that.props.onConversationSelection} />;
        })}
      </div>
    )
  }
})