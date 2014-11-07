class ResultSorter

  def initialize(results_hash)
    @results = results_hash
  end

  def sort(sort_params="")
    @sort_params = sort_params
    split_params
    sort_results(ordered_params)
  end

  private

  def sort_results(params)
    order = sort_order(params)

    @results.sort_by { |result| [result[order[:first]], result[order[:second]], result[order[:third]]] }
  end

  def sort_order(params)
    {
      first: determine_sort_item(params[0]),
      second: determine_sort_item(params[1]),
      third: determine_sort_item(params[2])
    }
  end

  def determine_sort_item(param)
    case param
      when "f"
        :filename
      when "k"
        :key
      when "v"
        :value
      else
        raise "#{param} is not a valid sorting parameter. Only 'k', 'v', and 'f' are allowed"
    end
  end

  def default_params
    ["f", "k", "v"]
  end

  def split_params
    params = @sort_params.split('').uniq
    @sort_params = sanitize_params(params)
  end

  def sanitize_params(params)
    params.delete_if{ |param| !default_params.include?(param) }
  end

  def ordered_params
    if params_need_sorting?
      determine_order
    else
      default_params
    end
  end

  def params_need_sorting?
    @sort_params.count > 0 && @sort_params != default_params
  end

  def determine_order
    x = 0
    final_params = default_params
    @sort_params.each do |param|
      final_params.insert(x, final_params.delete_at(final_params.index(param)))
      x += 1
    end
    final_params
  end

end