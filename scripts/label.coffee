PEEWEE_URL = 'http://vision.joocy.com/label'

format_response = (labels) ->
    firstIdx = Math.floor(Math.random() * labels.length)
    first = labels[firstIdx]
    labels.splice(firstIdx, 1)
    secondIdx = Math.floor(Math.random() * labels.length)
    second = labels[secondIdx]
    return "I see a #{first}, or maybe a #{second}"

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
             message.send format_reponse(labels)
