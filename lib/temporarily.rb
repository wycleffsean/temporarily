# frozen_string_literal: true

require 'temporarily/version'
require 'securerandom'

# Adds .temporarily class method to ActiveRecord classes
module Temporarily
  module_function

  def call(model, query)
    tmp_table, orig_table = tables_for(model)
    query = query.to_sql if query.respond_to?(:to_sql)
    model.connection.create_table(tmp_table, temporary: true, as: query)
    model.table_name = tmp_table
    log "#{model.name} USING TEMP TABLE (#{tmp_table}) #{query}"
    yield
  ensure
    model.table_name = orig_table
    log "#{model.name} USING FULL TABLE (#{orig_table})"
    model.connection.drop_table(tmp_table)
  end

  def tables_for(model)
    tmp_table = model.table_name + '_' + SecureRandom.hex
    [tmp_table, model.table_name]
  end

  def log(message)
    return unless defined? Rails
    Rails.logger.info message
  end
end
