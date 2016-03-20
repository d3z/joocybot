PEEWEE_URL = 'http://vision.joocy.com/label'

format_response = (labels, fullList) ->
    if fullList
        return labels
    else
        firstIdx = Math.floor(Math.random() * labels.length)
        first = labels[firstIdx]
        labels.splice(firstIdx, 1)
        secondIdx = Math.floor(Math.random() * labels.length)
        second = labels[secondIdx]
        return "I see a #{first}, or maybe a #{second}"

label = (message, fullList) ->
    image_url = encodeURIComponent(message.match[1])
    label_url = "#{PEEWEE_URL}/#{image_url}"
    mesage.http(label_url)
     .header('Accept', 'application/json')
     .get() (err, res, body) ->
         if err
             message.emote 'shrug'
             return
         response = JSON.parse body
         labels = response.labels
         message.send format_response(labels, fullList)


module.exports = (robot) ->

    robot.respond /look (.*)/i, (message) ->
        label(message, false)

    robot.respond /label (.*)/i, (message) ->
        label(message, true)
