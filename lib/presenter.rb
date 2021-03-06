class Presenter
  def most_visits_template(data)
    self.data = data
    format(
      <<~TEXT,
        Addresses with with most visits:
        %<data>s
      TEXT
      data: most_visits.join("\n")
    )
  end

  def uniq_views_template(data)
    self.data = data
    format(
      <<~TEXT,
        Addresses with most unique views:
        %<data>s
      TEXT
      data: uniq_visits.join("\n")
    )
  end

  private

  attr_accessor :data

  def most_visits
    data.map { |path, visits| message(path, visits, "", "visit") }
  end

  def uniq_visits
    data.map { |path, visits| message(path, visits, " unique", "view") }
  end

  def message(path, number, unique, werb)
    format(
      "%<path>s %<number>s%<unique>s %<werb>s",
      path: path,
      number: number,
      unique: unique,
      werb: pluralization(werb, number)
    )
  end

  def pluralization(werb, number)
    if number > 1
      werb + "s"
    else
      werb
    end
  end
end
