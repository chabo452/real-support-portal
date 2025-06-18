import React from "react";

function Nav() {
  return (
    <nav>
      <ul>
        <li><a href="/">求人情報</a></li>
        <li><a href="/dashboard">CSV</a></li>
        <li><a href="/chart">グラフ</a></li>
        <li><a href="/about">概要</a></li>
        <li><a href="/report">レポート</a></li>
      </ul>
    </nav>
  );
}

export default Nav;
