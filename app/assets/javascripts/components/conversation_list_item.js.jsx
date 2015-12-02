var ConversationListItem = React.createClass({
  getInitialState() {
    return {
      conversation: this.props.conversation,
    };
  },
  render: function() {
    var read = this.state.conversation.read
    var isSenderCurrentUser = this.props.conversation.is_last_message_sender_current_user
    var faClasses = classNames({
      "fa": true,
      "gray-lighter": true,
      "fa-check": read,
      "fa-reply": !read
    })
    var badgeClasses = classNames({
      "badge": true,
      "small-badge": true,
      "small-badge-off": read
    })
    var lastMessageInfo
    if(isSenderCurrentUser) {
      lastMessageInfo = <i className={faClasses}></i>&nbsp;&nbsp;
    } else {
      lastMessageInfo = <span className={badgeClasses}> </span>
    }

    return(
      <div className="conversation-preview-link" onClick={this.handleClick} key='test'>
        <div className="conversation-preview" id={"conversation_" + this.props.conversation.id}>
          <div className="col-xs-3 img-medium-square padding-none">
            <img src={this.props.conversation.picture} className="img"/>
          </div>
          <div className="col-xs-9 overflow-hidden padding-right-none">
            <ul className="list-inline list-unstyled margin-btm-none">
              <li><h5 className="margin-btm-5 first-name"><strong>{this.props.conversation.first_name}</strong></h5></li>
              <li className="pull-right margin-top-10 padding-sides-none"><p className="small-o gray-lighter text-right">{this.props.conversation.last_message_created_at}</p></li>
            </ul>
            <div className="one-line">
              {lastMessageInfo}
              <span dangerouslySetInnerHTML={{__html: this.props.conversation.last_content}}></span>
            </div>
          </div>
        </div>
      </div>
    )
  },
  handleClick: function() {

  }
})