json.extract! message, :id, :writer, :content, :read_at, :created_at

json.created_at l(message.created_at, format: "%A %e %B - %Hh%M").capitalize
json.first_name message.writer.first_name
json.content simple_format(auto_link(message.content, html: {target: "_blank"}), {}, sanitize: false)
json.writerUrl (message.writer.picture_file_name && message.writer.picture_file_name != "") ? message.writer.picture.url(:medium) : asset_path("user_pic-60.png")
json.writer_path user_path(message.writer)

