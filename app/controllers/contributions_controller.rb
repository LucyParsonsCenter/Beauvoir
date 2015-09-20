class ContributionsController < ApplicationController
  autocomplete :author, :full_name, :full=>true, :display_value=>:name_and_id_and_titles

  private

  def contribution_params
    params.require( :author_id, :title_id, :what, :author)
    params.permit( :author_id, :title_id, :what, :author)
  end
end
