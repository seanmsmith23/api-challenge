require 'rails_helper'

RSpec.describe ResultSorter, :type => :model do
  let(:given_results){
    [
      {filename: "b", key: "b", value: "a"},
      {filename: "b", key: "b", value: "b"},
      {filename: "a", key: "b", value: "a"},
      {filename: "b", key: "a", value: "a"},
      {filename: "a", key: "b", value: "b"},
      {filename: "a", key: "a", value: "a"}
    ].shuffle
  }

  it "should sort by default (filename, key, value) when not given sort params" do
    expected_results = [
      {filename: "a", key: "a", value: "a"},
      {filename: "a", key: "b", value: "a"},
      {filename: "a", key: "b", value: "b"},
      {filename: "b", key: "a", value: "a"},
      {filename: "b", key: "b", value: "a"},
      {filename: "b", key: "b", value: "b"}
    ]

    results = ResultSorter.new(given_results)

    expect(results.sort).to eq(expected_results)
  end

  it "should sort by value > filename > key when given 'v' as a sorting param" do
    expected_results = [
      {filename: "a", key: "a", value: "a"},
      {filename: "a", key: "b", value: "a"},
      {filename: "b", key: "a", value: "a"},
      {filename: "b", key: "b", value: "a"},
      {filename: "a", key: "b", value: "b"},
      {filename: "b", key: "b", value: "b"}
    ]

    sort_params = "v"

    results = ResultSorter.new(given_results)

    expect(results.sort(sort_params)).to eq(expected_results)
  end

  it "should sort by value > key > filename when given 'vk' as a sorting param" do
    expected_results = [
      {filename: "a", key: "a", value: "a"},
      {filename: "b", key: "a", value: "a"},
      {filename: "a", key: "b", value: "a"},
      {filename: "b", key: "b", value: "a"},
      {filename: "a", key: "b", value: "b"},
      {filename: "b", key: "b", value: "b"}
    ]

    sort_params = "vk"

    results = ResultSorter.new(given_results)

    expect(results.sort(sort_params)).to eq(expected_results)
  end

  it "should ignore extra parameters" do
    expected_results = [
      {filename: "a", key: "a", value: "a"},
      {filename: "a", key: "b", value: "a"},
      {filename: "b", key: "a", value: "a"},
      {filename: "b", key: "b", value: "a"},
      {filename: "a", key: "b", value: "b"},
      {filename: "b", key: "b", value: "b"}
    ]

    sort_params = "vvv"

    results = ResultSorter.new(given_results)

    expect(results.sort(sort_params)).to eq(expected_results)
  end

  it "should ignore params that are not 'f', 'k', or 'v'" do
    expected_results = [
      {filename: "a", key: "a", value: "a"},
      {filename: "b", key: "a", value: "a"},
      {filename: "a", key: "b", value: "a"},
      {filename: "b", key: "b", value: "a"},
      {filename: "a", key: "b", value: "b"},
      {filename: "b", key: "b", value: "b"}
    ]

    sort_params = "123ppxvk"

    results = ResultSorter.new(given_results)

    expect(results.sort(sort_params)).to eq(expected_results)
  end
end