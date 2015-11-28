var OverlayTrigger = ReactBootstrap.OverlayTrigger
var Tooltip = ReactBootstrap.Tooltip

var NeighborListItem = React.createClass({
  render: function() {
    var style = {
      backgroundImage: 'url(' + this.props.neighbor.picture + ')'
    }
    return (
      <div className="col-xs-6 col-sm-4">
        <div className="card">
          <span className="card-bg" style={style}></span>
          <span className="card-shadow"></span>
          <span className="card-description">
            {this.props.neighbor.description}
          </span>
          <span className="card-text">
            <h2>{this.props.neighbor.first_name}</h2>
          </span>
          <span className="card-user">
          </span>
          <OverlayTrigger placement="top" overlay={
            <Tooltip>
              {this.props.neighbor.description}
            </Tooltip>
          }>
            <a className="card-link" href={this.props.neighbor.neighbor_path}>
            </a>
          </OverlayTrigger>
        </div>
      </div>
    )
  }
})