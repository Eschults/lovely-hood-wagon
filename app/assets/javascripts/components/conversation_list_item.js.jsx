var ConversationListItem = React.createClass({
  getInitialState() {
    return {
      read: this.props.read
    };
  },
  render: function() {
    var faClasses = classNames({
      "fa": true,
      "gray-lighter": true,
      "fa-check": this.state.read,
      "fa-reply": !this.state.read
    })
    return(
      <a className="conversation-preview-link" onClick={this.handleClick}>
        <div className="conversation-preview" id={"conversation_" + this.props.conversation.id}>
          <div className="col-xs-3 img-medium-square padding-none">
            <img src={this.props.conversation.picture} className="img"/>
          </div>
          <div className="col-xs-7">
            <h5 className="margin-btm-5 first-name"><strong>{this.props.conversation.first_name}</strong></h5>
            <i className={faClasses}></i>&nbsp;&nbsp;

          </div>
          <div className="col-xs-2 margin-top-10 padding-none">
            <p className="small gray-lighter text-right margin-top-14">{this.props.conversation.last_message_created_at}</p>
          </div>
        </div>
      </a>
    )
  }
})