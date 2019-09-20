require_relative("../db/sql_runner.rb")

class Transaction

  attr_accessor :price, :user_id, :merchant_id, :category_id
  attr_reader :id

  def initialize(options)
    @price = options['price']
    @user_id = options['user_id'].to_i()
    @merchant_id = options['merchant_id'].to_i()
    @category_id = options['category_id'].to_i()
    @id = options['id'].to_i() if options['id']
  end

# INSTANCE METHODS

# CREATE
  def save()
    sql = "INSERT INTO transactions
    (price, user_id, merchant_id, category_id)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id"
    values = [@price, @user_id, @merchant_id, @category_id]
    transaction = SqlRunner.run(sql, values).first()
    @id = transaction['id'].to_i()
  end

# UPDATE
  def update()
    sql = "UPDATE transactions
    (price, user_id, merchant_id, category_id)
    =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@price, @user_id, @merchant_id, @category_id, @id]
    SqlRunner.run(sql, values)
  end

# DELETE
  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# CLASS METHODS

# READ ALL
  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    result = results.map { |result| Transaction.new(result)}
    return result
  end

# DELETE ALL
  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

end
