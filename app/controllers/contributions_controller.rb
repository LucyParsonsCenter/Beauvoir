class ContributionsController < ApplicationController
  private

  def contribution_params
    params.require( :author_id, :title_id, :what, :author)
    params.permit( :author_id, :title_id, :what, :author)
  end
end
