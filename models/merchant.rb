require_relative("../db/sql_runner.rb")

class Merchant

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i() if options['id']
  end

# INSTANCE METHODS

# CREATE
  def save()
    sql = "INSERT INTO merchants
    (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    merchant = SqlRunner.run(sql, values).first()
    @id = merchant['id'].to_i()
  end

# UPDATE
  def update()
    sql = "UPDATE merchants
    (name)
    =
    ($1)
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# CLASS METHODS

# READ ALL
  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run(sql)
    result = results.map { |result| Merchant.new(result)}
    return result
  end

# DELETE ALL
  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

end
