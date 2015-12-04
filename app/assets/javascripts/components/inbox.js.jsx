var Inbox = React.createClass({
  getInitialState: function() {
    return {
      conversations: this.props.conversations,
      selectedConversationId: this.props.conversation_id,
      firstName: this.props.first_name,
      messages: this.props.messages
    }
  },
  render: function() {
    return(
      <div className="row">
        <div className="col-md-4 inbox">
          <div className="panel panel-default margin-top-15 padding-none white-bg" id="panel-inbox">
            <div className="panel-heading border-btm-light">
              <h4>{this.props.inbox}</h4>
            </div>
            <div className="panel-body padding-none panel-body-inbox" id="conversations">
              <ConversationList conversations={this.state.conversations} onConversationSelection={this.handleConversationSelection} />
              <div className="conversation-preview" id="no-highlight">
                <p className="small margin-btm-3 gray-lighter text-center">
                  {this.props.end}
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="col-md-8 conversation">
          <div className="panel panel-default margin-top-15 padding-none" id="panel-conversation">
            <div className="panel-heading border-btm-light">
              <h4 id="first-name">
                {this.state.firstName}
              </h4>
            </div>
            <div className="panel-body panel-body-conversation padding-none">
              <div id="messages">
                <MessageList messages={this.state.messages} />
              </div>
              <div id="new_message">
                <CreateMessage conversationId={this.state.selectedConversationId} write_a_reply={this.props.write_a_reply} submit={this.props.submit} onMessageCreation={this.handleMessageCreation} />
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  },
  handleConversationSelection: function(conversationId) {
    var that = this;
    $.ajax({
      type: 'GET',
      url: Routes.conversation_path(conversationId, { format: 'json' }),
      success: function(data) {
        that.setState({
          conversations: data.conversations,
          selectedConversationId: data.conversation_id,
          firstName: data.first_name,
          messages: data.messages
        })
        $('#messages').scrollTop($('#messages')[0].scrollHeight);
        $('#message-input').focus()
      }
    })
  },
  handleMessageCreation: function(conversationId, messageContent) {
    var that = this;
    $.ajax({
      type: 'PUT',
      url: Routes.reply_conversation_path(conversationId, { format: 'json' }),
      data: {
        message: {
          content: messageContent
        }
      },
      success: function(data) {
        that.setState({
          conversations: data.conversations,
          selectedConversationId: data.conversation_id,
          firstName: data.first_name,
          messages: data.messages
        })
        $('#messages').scrollTop($('#messages')[0].scrollHeight);
        $('#message-input').val('').focus()
      }

    })
  }
})