var ConversationListItem = React.createClass({
  getInitialState() {
    return {
      conversation: this.props.conversation
    };
  },
  render: function() {
    var read = this.state.conversation.read
    var isSenderCurrentUser = this.props.conversation.is_last_message_sender_current_user
    var isSelectedConversation = this.props.conversation.is_selected_conversation
    var iClasses = classNames({
      "fa": isSenderCurrentUser,
      "fa-check": isSenderCurrentUser && read,
      "fa-reply": isSenderCurrentUser && !read,
      "badge": !isSenderCurrentUser,
      "small-badge": !isSenderCurrentUser,
      "small-badge-off": !isSenderCurrentUser && read
    })
    var divClasses = classNames({
      "conversation-preview": true,
      "selected-conversation": isSelectedConversation,
      "unread-messages": !isSenderCurrentUser && !read
    })
    return(
      <div className="conversation-preview-link" onClick={this.handleClick} key='test'>
        <div className={divClasses} id={"conversation_" + this.props.conversation.id}>
          <div className="col-xs-3 img-medium-square padding-none">
            <img src={this.props.conversation.picture} className="img"/>
          </div>
          <div className="col-xs-9 overflow-hidden padding-right-none">
            <ul className="list-inline list-unstyled margin-btm-none">
              <li><h5 className="margin-btm-5 first-name"><strong>{this.props.conversation.first_name}</strong></h5></li>
              <li className="pull-right margin-top-10 padding-sides-none"><p className="small-o gray-lighter text-right">{this.props.conversation.last_message_created_at}</p></li>
            </ul>
            <div className="one-line">
              <i className={iClasses}> </i>&nbsp;&nbsp;
              <span dangerouslySetInnerHTML={{__html: this.props.conversation.last_content}}></span>
            </div>
          </div>
        </div>
      </div>
    )
  },
  handleClick: function() {
    var that = this;
    $.ajax({
      type: 'GET',
      url: Routes.conversation_path(this.props.conversation.id, { format: 'json' }),
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
        $('#message-input').focus()
      }
    });
  }
})