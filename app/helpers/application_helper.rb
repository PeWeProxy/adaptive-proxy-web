# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  MAX_TEXT_LENGTH = 45

  def shorten text
    if text.length <= MAX_TEXT_LENGTH
      text
    else
      text[0..MAX_TEXT_LENGTH] + '...'
    end
  end
end
