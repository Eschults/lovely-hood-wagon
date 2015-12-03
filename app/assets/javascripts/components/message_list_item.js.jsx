var MessageListItem = React.createClass({
  render: function() {
    var imgClasses = classNames({
      "img": true,
      "logo-small": this.props.message.writerUrl.lastIndexOf("user_pic-60.png") > -1,
      "bg-color": this.props.message.writerUrl.lastIndexOf("user_pic-60.png") > -1
    })
    return (
      <div className="stick-down-target message white-bg col-xs-12" id={"message_" + this.props.message.id}>
        <div className="message-date">
          <span className="white-bg padding-sides-5">{this.props.message.created_at}</span>
        </div>
        <div className="message-content margin-top-10">
          <div className="col-xs-3 img-small-square padding-none">
            <img src={this.props.message.writerUrl} className={imgClasses}/>
          </div>
          <div className="col-xs-9 padding-left-10">
            <h5 className="margin-top-none margin-btm-5">
              <a href={this.props.message.writer_path} className="nice-link">{this.props.message.first_name}</a>
            </h5>
            <div dangerouslySetInnerHTML={{__html: this.props.message.content}}></div>
          </div>
        </div>
      </div>
    )
  }
})