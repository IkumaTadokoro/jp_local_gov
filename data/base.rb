# frozen_string_literal: true

require "sqlite3"

module JpLocalGov
  module Data
    class Base
      def db
        @db ||= SQLite3::Database.new("tmp/test.db")
      end

      def reset_table
        drop_table
        create_table
      end

      def drop_table
        db.execute <<-SQL
          DROP TABLE IF EXISTS local_governments;
        SQL
      end

      def create_table
        db.execute <<-SQL
          CREATE TABLE local_governments (
            code VARCHAR(5),
            prefecture_code VARCHAR(2),
            prefecture VARCHAR(256),
            prefecture_kana VARCHAR(256),
            city VARCHAR(256),
            city_kana VARCHAR(256),
            prefecture_capital VARCHAR(10)
          );
        SQL

        db.execute <<-SQL
          CREATE INDEX idx_local_governments ON local_governments (prefecture, city);
        SQL
      end

      def retrieve_and_save
        db.execute "BEGIN TRANSACTION"
        retrieve.each do |hash|
          insert(hash)
        end
        db.execute "COMMIT"
      end

      INSERT_SQL = <<-SQL
        INSERT INTO local_governments (
          code,
          prefecture_code,
          prefecture,
          prefecture_kana,
          city,
          city_kana,
          prefecture_capital
        ) VALUES (?, ?, ?, ?, ?, ?, ?);
      SQL

      private

      def insert(hash)
        db.execute(
          INSERT_SQL,
          hash[:code],
          hash[:prefecture_code],
          hash[:prefecture],
          hash[:prefecture_kana],
          hash[:city],
          hash[:city_kana],
          hash[:prefecture_capital]
        )
      end
    end
  end
end
