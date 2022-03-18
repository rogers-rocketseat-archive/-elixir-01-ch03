defmodule GenReport do
  alias GenReport.Parser

  # defp report_vazio() do
  #   %{
  #     "cleiton" => 0,
  #     "daniele" => 0,
  #     "danilo" => 0,
  #     "diego" => 0,
  #     "giuliano" => 0,
  #     "jakeliny" => 0,
  #     "joseph" => 0,
  #     "mayk" => 0,
  #     "rafael" => 0,
  #     "vinicius" => 0
  #   }
  # end

  @names [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_struct(), fn line, report -> get_hours(line, report) end)
  end

  def build() do
    {:error, "Insira o nome de um arquivo"}
  end

  defp get_hours([name, hours, _day, _month, _year], %{"all_hours" => names} = report) do
    names = Map.put(names, name, names[name] + hours)
    %{report | "all_hours" => names}
  end

  defp report_struct() do
    names = Enum.into(@names, %{}, &{&1, 0})
    %{"all_hours" => names}
  end
end

# Retornar ->
# %{
#   all_hours: %{
#         danilo: 500,
#         rafael: 854,
#         ...
#     },
#   hours_per_month: %{
#         danilo: %{
#             janeiro: 40,
#             fevereiro: 64,
#             ...
#         },
#         rafael: %{
#             janeiro: 52,
#             fevereiro: 37,
#             ...
#         }
#     },
#   hours_per_year: %{
#         danilo: %{
#             2016: 276,
#             2017: 412,
#             ...
#         },
#         rafael: %{
#             2016: 376,
#             2017: 348,
#             ...
#         }
#     }
# }
