var parser = require("./parser.js")
var result = parser.parse(`
#########################################################################
# Fighter Focus
#########################################################################


fighter_pilot_training = {

  interceptor = {
    default_organisation = 5
  }

  multi_role = {
    default_organisation = 5
  }
  cag = {
    default_organisation = 1
  }
  rocket_interceptor = {
    default_organisation = 3
  }

  allow = {
    single_engine_aircraft_design = 1
  }

  research_bonus_from = {
    fighter_focus = 0.3
    air_doctrine_practical = 0.7
  }

  change = no
  on_completion = fighter_focus

  difficulty = 5

  #common for all techs.
  start_year = 1918
  first_offset = 1936 #2nd model is from 1936
  additional_offset = 2 #one new every 2 years
  max_level = 12
  folder = air_doctrine_folder
}
alpini_brigade = {
  usable_by = { ITA }
}
`)
console.log(result)
