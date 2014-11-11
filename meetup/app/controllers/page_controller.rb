class PageController < ApplicationController
  def welcome
    @issues  = Issue.all.reverse
  end
end
