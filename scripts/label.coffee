module.exports = (robot) ->

    robot.hear /look/i, (res) ->
        robot.logger.info "I'm looking"
