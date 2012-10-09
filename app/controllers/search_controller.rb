# SearchController demonstrates how to do a Swiftype search on your
# server (as opposed to using the JavaScript).
#
# It is not linked to in the app, but you can visit it at /search
class SearchController < ApplicationController
  def search
    if params[:q]
      client = Swiftype::Easy.new
      results = client.search(ENV['SWIFTYPE_ENGINE_SLUG'], params[:q])
      @post_results = results['post']
    end
  end
end