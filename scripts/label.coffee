PEEWEE_URL = 'http://vision.joocy.com/label'

module.exports = (robot) ->

    robot.respond /look (.*)/i, (message) ->
        image_url = encodeURIComponent(message.match[1])
        label_url = "#{PEEWEE_URL}/#{image_url}"
        robot.logger.info "I'll ask about #{label_url}"
        robot.http(label_url)
         .header('Accept', 'application/json')
         .get() (err, res, body) ->
             if err
                 message.emote 'shrug'
                 return
             robot.logger.info "I got a response"
             response = JSON.parse body
             labels = response.labels
             message.send labels.join()
