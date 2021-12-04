package com.example.app

import cats.effect.IOApp
import cats.effect.IO

object Main extends IOApp.Simple:
  def run: IO[Unit] =
    IO.println("Hello Nix!")
