var CreateMessage = React.createClass({
  getInitialState() {
    return {
      conversation: this.props.conversation
    };
  },
  render: function() {
    return(
      <div className="stick-down-target reply" id={"reply_conversation_" + this.props.conversation_id}>
        <div className="form-group margin-btm-10">
          <textarea className="form-control" placeholder={this.props.write_a_reply} id="message-input" />
        </div>
        <div className="form-group margin-btm-none text-right">
          <button className="btn btn-post" onClick={this.handleClick}>{this.props.submit}</button>
        </div>
      </div>
    )
  },
  handleClick: function() {
    var that = this;
    $.ajax({
      type: 'PUT',
      url: Routes.reply_conversation_path(this.props.conversation_id, {format: 'json'}),
      data: {
        message: {
          content: $('#message-input').val()
        }
      },
      success: function(data) {
        ReactDOM.render(<MessageList messages={data.messages} started_at={data.started_at} lastMessageId={data.lastMessageId}/>, document.getElementById('messages'))
        $('#messages').scrollTop($('#messages')[0].scrollHeight);
        $('#first-name').text(data.firstName)
        ReactDOM.render(<ConversationList conversations={data.conversations} conversation_id={data.conversation_id} />, document.getElementById('conversations'))
        var conversation = data.conversations.filter(function(item) {
          return item.id == data.conversation_id
        })
        var heroConversation = conversation[0]
        that.setState({
          conversation: heroConversation
        });
        ReactDOM.render(<CreateMessage conversation_id={data.conversation_id} write_a_reply={data.write_a_reply} submit={data.submit} />, document.getElementById('new_message'))
        $('#message-input').val('').focus()
      }
    });
  }
})