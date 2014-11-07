class AwsS3

  def self.get(sort_params="")
    @results = ResultSorter.new(get_results)
    @results.sort(sort_params)
  end

  def self.get_results
    bucket_objects.map do |obj|
      parse_object(obj)
    end.flatten
  end

  private

  def self.bucket_objects
    conn = aws_conn
    conn.buckets[ENV["AWS_S3_BUCKET"]].objects
  end

  def self.aws_conn
    AWS::S3.new({
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_KEY"]
    })
  end

  def self.parse_object(obj)
    split_lines(obj).map do |line|
      tabs = split_tabs(line)
      {filename: obj.key, key: tabs[0], value: tabs[1]}
    end
  end

  def self.split_lines(obj)
    obj.read.split("\n")
  end

  def self.split_tabs(line)
    line.split("\\t")
  end

end