class Product
  include ActiveData::Model
  attribute :description, String
  attribute :balance_code, String

  attribute :price, Float
  attribute :promotional_price, Float
  attribute :fator_promotional_price, Float
  attribute :fator_promotional, Float
  validates :description, :price, presence: true
  def id
    balance_code || SecureRandom.random_number(10_000)
  end

  def promotional_price=(value)
    super
    self[:promotional_price] = nil if value.zero?
  end

  def fator_promotional_price=(value)
    super
    self[:fator_promotional_price] = nil if value.zero?
  end

  def fator_promotional=(value)
    super
    self[:fator_promotional] = nil if value.zero?
  end

  def self.find_all_by_balance_codes(balance_codes:, unit_code:, connection:)
    codes = balance_codes.map { |e| "'#{e}'" }.join(',')
    query = "SELECT substring(prod_codbarras,7, 6) AS balance_code,
            prod_descrpdvs AS description,
            prun_prpdv AS price,
            prun_prvenda2 AS promotional_price
            FROM produtos
            JOIN produn ON (prod_codigo = prun_prod_codigo)
            WHERE prun_unid_codigo='#{unit_code}'
            AND prun_ativo = 'S' AND prun_prpdv <> '0'
            AND prod_balanca IN ('P', 'U')
            AND substring(prod_codbarras, 7, 6) IN (#{codes})
            ORDER BY prod_descricao"
    get_all_by_query(connection, query)
  end

  def self.find_by_barcode(barcode, connection:, unit_code:)
    query = if barcode.starts_with?('888')
              "SELECT SUM(cesd_qtde*cesd_prvenda) AS price,
              cesc_descricao AS description
              FROM cestabasicac
              JOIN cestabasicad ON (cesc_codigo=cesd_codigo)
              WHERE cesc_codigo = '#{barcode}' GROUP BY cesc_descricao"
            else
              "SELECT prun_prpdv AS price,
              prun_prvenda2 AS promotional_price,
              prod_descricao AS description,
              PRUN_PRPDV3 as fator_promotional_price,
              prun_fatorpr3 as fator_promotional
              FROM produtos
              JOIN produn ON (prod_codigo=prun_prod_codigo)
              WHERE prun_unid_codigo='#{unit_code}'
              AND prun_ativo='S'
              AND prun_prpdv <>'0'
              AND prod_codbarras LIKE '%#{barcode}'"
            end
    items = get_all_by_query(connection, query)
    items[0]
  end

  def self.get_all_by_query(connection, query)
    items = []
    begin
      cursor = connection.exec(query)
      cols = cursor.fields
      p cursor.field_name_type
      cursor.each_row do |row|
        item = {}
        cols.each do |col|
          item[col] = row[cols.index(col)]
        end
        items << Product.new(item)
      end
    rescue PG::Error => e
      puts e.message
    ensure
      connection.close if connection
    end
    items
  end
end
