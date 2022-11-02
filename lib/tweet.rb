class Tweet
  #creatipersisting objects to database
  #create a table for the class
  #return all records of a table
  # find al records of table
  #to persist or push object sto database

  #method that cretes he table
  attr_accessor :user,:content,:id

  def initialize(attr_hash={})
    attr_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  def self.create_table
   sql = <<-SQL
   CREATE TABLE IF NOT EXISTS tweets (
    id INTEGER PRIMARY KEY,
    user TEXT,
    content TEXT
    );
   SQL
  end
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO tweets (user,content) VALUES (?,?);
      SQL
      DB[:conn].execute(sql,self.user,self.content)
      #last insendert row id
      @id = DB[:conn].last_insert_row_id
   end
    self
  end
  def self.all
    sql = <<-SQL
      SELECT * FROM tweets
    SQL
   records = DB[:conn].execute(sql)
   records.map do |record_hash|
    Tweet.new(record_hash)
   end
  end
  def update
    sql = <<-SQL
      UPDATE tweets SET user=? ,content = ? WHERE id = ?
    SQL
    Db[.conn].execute(sql,self.user,self.content,self.id)
  end
  def self.find(id)
    sql = <<-SQL
    SELECT * FROM tweets WHERE tweets.id =?
    Db[.conn].execute(sql,id)
  SQL
  end
end
