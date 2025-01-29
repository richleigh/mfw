#include "lib.hpp"

auto main() -> int
{
  auto const lib = library {};

  return lib.name == "mfw" ? 0 : 1;
}
