import React from "react";

function Nav() {
  return (
    <nav>
      <ul>
        <li><a href="/">ホーム</a></li>
        <li><a href="/dashboard">CSV</a></li>
        <li><a href="/chart">グラフ</a></li>
        <li><a href="/about">理念</a></li>
        <li><a href="/report">レポート</a></li>
      </ul>
    </nav>
  );
}

export default Nav;
