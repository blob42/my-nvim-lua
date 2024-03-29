return {
    -- AGPL3
    s("AGPL3", fmt([[
    # The AGPLv3 License (AGPLv3)
    # 
    # Copyright (c) 2023 {}
    # 
    # {} is free software: you can redistribute it and/or modify
    # it under the terms of the GNU Affero General Public License as
    # published by the Free Software Foundation, either version 3 of the
    # License, or (at your option) any later version.
    # 
    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU Affero General Public License for more details.
    # 
    # You should have received a copy of the GNU Affero General Public License
    # along with this program.  If not, see <http://www.gnu.org/licenses/>.
    ]], {
        i(1), i(0)
    })),
    s("tyt", t("import typing as t")),
    -- docstring
    s("d", fmt([["""{}"""]], {i(1)})),

    -- mypy reveal_type
    s("revl", fmt([[reveal_type({})]], {i(1)})),

    -- quick print debug
    s("dbgp", fmt([[print(f"---\n\n{{{}}}---\n\n")]], {i(0)})),
}, { --autosnippets
    -- s("uuid#", f(gen_uuid))
    s("ret ", t("return ")),

    -- f-string
    s("f-", fmt([[f"{}"]], {i(1)})),

    -- mypy #ignore
    s("#ign", t"  # type: ignore"),
}
