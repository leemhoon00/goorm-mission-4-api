import { Controller, Get, Post, Body } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Post()
  async createOne(@Body() data: { name: string }) {
    await this.usersService.insertOne(data);
  }

  @Get()
  async findAll() {
    return await this.usersService.findAll();
  }
}
