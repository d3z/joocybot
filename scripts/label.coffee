PEEWEE_URL = 'http://vision.joocy.com/label'

module.exports = (robot) ->

    robot.hear /look (.*)/i, (res) ->
        image_url = encodeURIComponent(res.match[1])
        label_url = "#{PEEWEE_URL}/#{image_url}"
        robot.logger.info "I'll ask about #{label_url}"
