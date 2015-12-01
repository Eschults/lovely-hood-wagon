var NeighborList = React.createClass({
  render: function() {
    return (
      <div className="panel-body padding-none" id="neighbors-stream">
        {this.props.neighbors.map(function(neighbor, index) {
          return <NeighborListItem neighbor={neighbor} key={index} />
        })}
      </div>
    )
  }
})