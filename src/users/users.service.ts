import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { CreateUserDto, GetUsersDto } from './users.dto';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async insertOne(data: CreateUserDto): Promise<void> {
    await this.prisma.user.create({ data });
  }

  async findAll(): Promise<GetUsersDto[]> {
    return await this.prisma.user.findMany();
  }
}
