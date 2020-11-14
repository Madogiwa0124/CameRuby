# fornzen_string_literal: true

require_relative './lib/cameRuby/methodMissing'
class Object
  include CameRuby::MethodMissing
end

# require_relative './lib/cameRuby/aliasMethod'
# CameRuby::AliasMethod.call

puts 'foo'.respondTo?(:toS, false)
puts 'foo'.toS
puts String.respondTo?(:tryConvert, false)
puts String.tryConvert('str')

class Book
  include CameRuby

  def initialize(name, publishedAt)
    @name = name
    @publishedAt = publishedAt
  end

  attr_reader :name, :publishedAt
end

book = Book.new('foo', Time.now)
p book.name
p book.publishedAt.toS

n = 100000
Benchmark.bm(7, ">total:", ">avg:") do |x|
  x.report("to_s:") { "foo".to_s }
  x.report("toS:") { "foo".toS }
end

