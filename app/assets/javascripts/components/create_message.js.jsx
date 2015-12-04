var CreateMessage = React.createClass({
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
    this.props.onMessageCreation(this.props.conversationId, $('#message-input').val())
  }
})