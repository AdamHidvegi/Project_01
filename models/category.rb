require_relative("../db/sql_runner.rb")

class Category

  attr_accessor :tag, :name
  attr_reader :id

  def initialize(options)
    @tag = options['tag']
    @name = options['name']
    @id = options['id'].to_i() if options['id']
  end

# INSTANCE METHODS

# CREATE
  def save()
    sql = "INSERT INTO categories
    (tag, name)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@tag, @name]
    category = SqlRunner.run(sql, values).first()
    @id = category['id'].to_i()
  end

# UPDATE
  def update()
    sql = "UPDATE categories
    (tag, name)
    =
    ($1, $2)
    WHERE id = $3"
    values = [@tag, @name, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM categories
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# CLASS METHODS

# READ ALL
  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run(sql)
    result = results.map { |result| Category.new(result)}
    return result
  end

# DELETE ALL
  def self.delete_all()
    sql = "DELETE FROM categories"
    SqlRunner.run(sql)
  end

end
