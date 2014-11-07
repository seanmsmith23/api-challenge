class QueriesController < ApplicationController
  def show
    @aws_results = AwsS3.get(allowed_params)
    render json: @aws_results
  end

  private

  def allowed_params
    params["sort"] ? params["sort"] : ""
  end

end
