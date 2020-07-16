# frozen_string_literal: true

class ProjectsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:project].to_i,
      iTotalRecords: Project.count,
      iTotalDisplayRecords: projects.total_entries,
      aaData: data
    }
  end

  private

  def data
    projects.map do |project|
      [
        link_to(project.name, project),
        h(project.user_id),
        h(project.created_at.strftime('%B %e, %Y'))
      ]
    end
  end

  def projects
    @projects ||= fetch_projects
  end

  def fetch_projects
    projects = project.order("#{sort_column} #{sort_direction}")
    projects = projects.page(page).per_page(per_page)
    if params[:sSearch].present?
      projects = projects.where('name like :search or category like :search', search: "%#{params[:sSearch]}%")
    end
    projects
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name category released_on price]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
